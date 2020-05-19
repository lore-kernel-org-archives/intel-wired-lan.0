From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 19 May 2020 14:37:17 -0500
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 105/183]
 sound/soc/sof/intel/apl.c:167:1: error: type defaults to 'int' in
 declaration of 'MODULE_IMPORT_NS'
In-Reply-To: <202005200349.7ZATWxlp%lkp@intel.com>
References: <202005200349.7ZATWxlp%lkp@intel.com>
Message-ID: <8b058daf-f870-b126-cd1d-d935bdadbf52@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> sound/soc/sof/intel/apl.c:167:1: warning: data definition has no type or storage class
> 167 | MODULE_IMPORT_NS(SND_SOC_SOF_CLIENT);
> | ^~~~~~~~~~~~~~~~
>>> sound/soc/sof/intel/apl.c:167:1: error: type defaults to 'int' in declaration of 'MODULE_IMPORT_NS' [-Werror=implicit-int]
> sound/soc/sof/intel/apl.c:167:1: warning: parameter names (without types) in function declaration
> cc1: some warnings being treated as errors
> --
> sound/soc/sof/intel/cnl.c:444:1: warning: data definition has no type or storage class
> 444 | MODULE_IMPORT_NS(SND_SOC_SOF_CLIENT);
> | ^~~~~~~~~~~~~~~~
>>> sound/soc/sof/intel/cnl.c:444:1: error: type defaults to 'int' in declaration of 'MODULE_IMPORT_NS' [-Werror=implicit-int]
> sound/soc/sof/intel/cnl.c:444:1: warning: parameter names (without types) in function declaration
> cc1: some warnings being treated as errors

valid issue, the following diff seems to solve it. No idea why it shows 
up no sparc64.

diff --git a/sound/soc/sof/intel/apl.c b/sound/soc/sof/intel/apl.c
index 0565ff315681..547b2b0ccb9a 100644
--- a/sound/soc/sof/intel/apl.c
+++ b/sound/soc/sof/intel/apl.c
@@ -15,6 +15,7 @@
   * Hardware interface for audio DSP on Apollolake and GeminiLake
   */

+#include <linux/module.h>
  #include "../sof-priv.h"
  #include "hda.h"
  #include "../sof-audio.h"
diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 9a40293f872d..0eedb39e1c89 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -15,6 +15,7 @@
   * Hardware interface for audio DSP on Cannonlake.
   */

+#include <linux/module.h>
  #include "../ops.h"
  #include "hda.h"
  #include "hda-ipc.h"
