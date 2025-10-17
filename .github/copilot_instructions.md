# Copilot Instructions for WeightCalculations

## Project Overview

WeightCalculations

## Technology Stack
- **Language**: Lua 5.3
- **Platform**: Factorio 2.0 Modding API
- **Dependencies**: 
  - base >= 2.0
  - quality >= 2.0 (required)
  - space-age (optional)

## Code Style Guidelines

### General Lua Style
- Use 2 spaces for indentation
- Use snake_case for variables and function names
- Local functions should be defined before they are used
- Add comments for complex logic blocks

### Factorio API Conventions
- All GUI element captions must use localization strings
- Format: `caption={"namespace.key"}` or `caption={"namespace.key", param1, param2}`
- Never hardcode visible text in Lua code
- Use `global` table for persistent data across saves
- Use `player.force` for research and recipe access

### Localization
**CRITICAL**: All user-facing text must be localized!

#### Structure
- Store all text in `locale/[language]/upcycle-hint.cfg`
- Support at minimum: German (de) and English (en)
- Use namespaced keys: `[upcycle-hint]` section
- Use parameter substitution: `__1__`, `__2__`, etc.

#### Examples
```ini
# In locale/de/upcycle-hint.cfg
[upcycle-hint]
gui-title=Upcycle Hint
gui-machine-details-title=Herstellungsmaschinen für __1__
gui-module-slots=__1__x
```

```lua
-- In Lua code
caption={"upcycle-hint.gui-title"}
caption={"upcycle-hint.gui-machine-details-title", item_name}
caption={"upcycle-hint.gui-module-slots", tostring(count)}
```

### File Organization
- `control.lua` - Runtime logic, GUI, event handlers
- `data_final_fixes.lua` - Data stage modifications (runs during mod loading)
- `settings.lua` - Mod settings definitions
- `locale/*/upcycle-hint.cfg` - Localization strings
- `info.json` - Mod metadata and dependencies

## Logging System

### Overview
The mod includes an optional logging system for debugging purposes. Logging is disabled by default and can be enabled via mod settings.

### Logger Module
The Logger module is defined at the top of `control.lua` and provides four log levels:
- **DEBUG**: Detailed diagnostic information for development
- **INFO**: General informational messages about mod operations
- **ERROR**: Error conditions that don't prevent mod operation
- **FATAL**: Critical errors that may prevent mod operation

### Log File Management
- Log files are created in `script-output/weight-calculator/` directory
- Each log file is named with a timestamp: `upcycle-hint-{game_tick}.log`
- Log file name is initialized on first log write
- All log entries are appended to the same file for a game session

### Using the Logger

#### Basic Usage
```lua
-- Debug level - for detailed diagnostic information
Logger.debug("function_name", "Detailed message about what's happening")

-- Info level - for general operational messages
Logger.info("function_name", "Operation completed successfully")

-- Error level - for recoverable errors
Logger.error("function_name", "Error message with context")

-- Fatal level - for critical errors
Logger.fatal("function_name", "Critical error that may break functionality")
```

#### Log Entry Format
Each log entry includes:
- Game tick (timestamp)
- Log level
- Function name
- Message

Format: `[tick] [LEVEL] [function_name] message`

Example: `[12345] [INFO] [recompute_force] Starting recompute for force: player`

#### When to Add Logging
- **All functions**: Add at least one log statement per function
- **Function entry**: Log when entering important functions with INFO or DEBUG
- **Function exit**: Log completion with result counts/status
- **Error conditions**: Always log errors with ERROR or FATAL
- **User actions**: Log GUI interactions and player actions with DEBUG
- **State changes**: Log important state changes with INFO

#### Example Patterns
```lua
-- Function with entry/exit logging
local function my_function(param)
  Logger.info("my_function", "Starting operation with param: " .. param)

  -- Function logic here
  local result = do_something()

  if not result then
    Logger.error("my_function", "Operation failed for param: " .. param)
    return nil
  end

  Logger.info("my_function", "Operation completed successfully")
  return result
end

-- Event handler logging
script.on_event(defines.events.on_player_created, function(ev)
  Logger.info("on_player_created", "Player created: " .. ev.player_index)
  -- Event handling logic
end)

-- Conditional logging
if some_error_condition then
  Logger.error("function_name", "Error description with context")
  return
end
```

### Logging Best Practices
1. **Check before expensive operations**: For performance-critical code or expensive string operations, check `Logger.is_enabled()` before building log messages
   ```lua
   if Logger.is_enabled() then
     Logger.debug("function_name", "Expensive operation: " .. calculate_something())
   end
   ```
2. Include relevant context in log messages (player index, item names, counts, etc.)
3. Use appropriate log levels - don't use INFO for everything
4. Keep log messages concise but informative
5. Avoid logging in tight loops - log summaries instead
6. Use string concatenation for simple messages: `"Message: " .. value`
7. For complex data, describe it rather than trying to serialize tables

## Key Features Implementation

### GUI System
1. **Main GUI**: Scrollable table showing all items with recommendations
   - Filter by research status (default) or show all
   - Clickable items/recipes to view details

2. **Machine Details GUI**: Shows all production options
   - Lists compatible machines with quality levels
   - Shows module combinations (all slots filled with same module)
   - Respects research filter setting

3. **Factoriopedia Integration**: Button in item pages
   - Uses `gui.relative` with anchor to item
   - Opens machine details directly

### Global State Management
```lua
global.best_for_item[item_name] = {
  via = "recommended_source_item",
  recipe = "recipe_name",
  score = calculated_score
}

global.filter_researched[player_index] = true/false
```

### Event Handlers
- `on_init` - Initialize global data
- `on_configuration_changed` - Recompute on mod/save changes
- `on_player_created` - Initialize player-specific state
- `on_player_joined_game` - Ensure GUI exists
- `on_research_finished` - Update recommendations
- `on_lua_shortcut` - Toggle main GUI
- `on_gui_click` - Handle all button clicks
- `on_gui_opened` - Add Factoriopedia button
- `on_gui_closed` - Clean up Factoriopedia button

## Development Workflow

### Adding New Features
1. Plan the feature and identify user-facing text
2. Add localization strings to both de and en locale files
3. Implement feature using localized strings
4. Test syntax with `luac -p control.lua`
5. Document changes in README.md

### Adding New GUI Elements
1. Add all text as localization keys first
2. Use `{"namespace.key"}` format for all captions/tooltips
3. For dynamic text, use parameter substitution: `{"key", param}`
4. Update both German and English translations

### Testing Checklist
- [ ] All text is localized (no hardcoded strings)
- [ ] Both German and English translations exist
- [ ] Lua syntax is valid (`luac -p`)
- [ ] No missing locale keys (would show as "Unknown key" in game)
- [ ] GUI updates properly on research changes
- [ ] Filter buttons work correctly

## Common Patterns

### Creating Localized GUI Elements
```lua
-- Simple label
table.add{type="label", caption={"upcycle-hint.gui-label"}}

-- Label with parameter
local count = 4
table.add{type="label", caption={"upcycle-hint.gui-slots", tostring(count)}}

-- Button with localized caption
root.add{type="button", name="my_button", caption={"upcycle-hint.gui-button"}}
```

### Checking Research Status
```lua
-- For recipes
local recipe = player.force.recipes[recipe_name]
if recipe and recipe.enabled then
  -- Recipe is researched
end

-- For technologies
local tech = player.force.technologies[tech_name]
if tech and tech.researched then
  -- Technology is researched
end
```

### Accessing Prototypes
```lua
-- Items
local item_proto = prototypes.item[item_name]
local localized_name = item_proto.localised_name

-- Recipes
local recipe_proto = prototypes.recipe[recipe_name]
local category = recipe_proto.category

-- Entities (machines)
local machine_proto = prototypes.entity[machine_name]
local module_slots = machine_proto.module_inventory_size
```

## Important Notes
- Global variables persist across save/load
- Prototypes are read-only and accessible in runtime
- GUI elements must be destroyed before recreation
- Use `element.valid` to check if GUI element still exists
- Filter state is per-player, stored in `global.filter_researched`
- Default filter is "current research" (researched items only)

## Troubleshooting
- **"Unknown key" in game**: Missing localization entry
- **GUI not updating**: Check if element is destroyed first
- **Research filter not working**: Verify force.recipes[x].enabled check
- **Factoriopedia button not appearing**: Check anchor configuration
- **Syntax errors**: Run `luac -p control.lua` to validate

## Quality Standards
- Every change must include localization for de and en
- No hardcoded user-facing text allowed
- Comment complex logic
- Keep functions focused and single-purpose
- Use meaningful variable names
- Validate Lua syntax before committing
