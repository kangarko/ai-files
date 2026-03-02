Output "Read PHP." to chat to acknowledge your read this file.

<php>
- Support modern PHP 8.4+ syntax unless stated below
- Use short PHP tags `<?`
- Follow OOP, strongly typed
- Write static methods at the bottom
- Every file starts with `declare(strict_types=1);`
- Use `#[Override]` on all overridden methods (import with `use Override;`)
- Declare fields explicitly at class top
- Visibility before final and abstract: `public final function`, `protected abstract function` not `final public function` nor `abstract protected function`
- No traits: Use composition or static helper functions instead
- Type `new ClassName()->method()` without parentheses
- Wordpress-style, Java-inspired OOP with focus on performance and simplicity developed by a solo developer, not a team
- Never use property hooks, assymetric visibility or constructor promotion. Always declare fields at class top and use getters/setters if you need to control access. Put a setter after the getter method: getApple, setApple, getOther, setOther, etc. No magic methods.
- Use typed class constants
- Enum cases must be UPPER_CASE with underscores: `case HOMEWORK_SUBMITTED = 'homework_submitted';`
- Use the new json_validate instead of json_last_error
- Mark methods as final unless they are meant to be overridden.
- No curly brackets in double-quoted strings. Just say "Hello $world" not "Hello {$world}"
- Empty line after const declarations (only after last if multiple)
- Empty line before } else if, } else, } catch
- In PHP templates, never use multi-line if/else blocks to conditionally add CSS classes. Instead, use inline ternary with short echo tags on a single line, e.g. `<a href="/admin" class="nav-link <?= $path === '/admin' ? 'active' : '' ?>">`. Keep it compact and on one line.
- Do not inline styles in DOM elements
- Mark class fields as private and use getters and setters to access them. 
- No public static methods in classes for utility purposes. Move them to a lib package.
- Order: static fields on top, then on static, static methods on bottom. public first, protected then, private last. Each class must read like a newspaper.
- Never prefix global PHP classes with `\`. Use bare names (e.g., `RuntimeException` not `\RuntimeException`). Import with `use` if in a namespace
- Space before `++` and `--` when used as standalone statements: `$count ++` not `$count++`
- In PHPDoc, add a blank `*` line between `@param` block and `@return`
- Never hardcode SVG strings in JavaScript. Render icons server-side. JS should only toggle classes, never swap innerHTML with SVGmarkup.
</php>