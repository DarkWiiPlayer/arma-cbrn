## Arma 3 CBRN scripts

Tracks unit exposure to CBRN hazards (currently supports chemical and
radiological hotspots) and their long-term effects.

Add this block to your `description.ext` file:

```cpp
// Default protection values for clothing items
#include "functions\cbrn\defaults.hpp"

// The actual functions
class CfgFunctions
{
	class DWP
	{
		#include "functions\cbrn\functions.hpp";
	};
};
```
