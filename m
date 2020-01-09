From: Jiri Pirko <jiri@resnulli.us>
Date: Thu, 9 Jan 2020 08:01:46 +0100
Subject: [Intel-wired-lan] [PATCH 2/4] doc: fix typo of snapshot in
 documentation
In-Reply-To: <20200109010818.1326575-3-jacob.e.keller@intel.com>
References: <20200109010818.1326575-1-jacob.e.keller@intel.com>
 <20200109010818.1326575-3-jacob.e.keller@intel.com>
Message-ID: <20200109070146.GB2235@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thu, Jan 09, 2020 at 02:08:17AM CET, jacob.e.keller at intel.com wrote:
>A couple of locations accidentally misspelled snapshot as shapshot.

This does not have anything to do with the rest of the set.

>
>Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>---
> Documentation/admin-guide/devices.txt    | 2 +-
> Documentation/media/v4l-drivers/meye.rst | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
>index 1c5d2281efc9..2a97aaec8b12 100644
>--- a/Documentation/admin-guide/devices.txt
>+++ b/Documentation/admin-guide/devices.txt
>@@ -319,7 +319,7 @@
> 		182 = /dev/perfctr	Performance-monitoring counters
> 		183 = /dev/hwrng	Generic random number generator
> 		184 = /dev/cpu/microcode CPU microcode update interface
>-		186 = /dev/atomicps	Atomic shapshot of process state data
>+		186 = /dev/atomicps	Atomic snapshot of process state data
> 		187 = /dev/irnet	IrNET device
> 		188 = /dev/smbusbios	SMBus BIOS
> 		189 = /dev/ussp_ctl	User space serial port control
>diff --git a/Documentation/media/v4l-drivers/meye.rst b/Documentation/media/v4l-drivers/meye.rst
>index a572996cdbf6..dc57a6a91b43 100644
>--- a/Documentation/media/v4l-drivers/meye.rst
>+++ b/Documentation/media/v4l-drivers/meye.rst
>@@ -95,7 +95,7 @@ so all video4linux tools (like xawtv) should work with this driver.
> 
> Besides the video4linux interface, the driver has a private interface
> for accessing the Motion Eye extended parameters (camera sharpness,
>-agc, video framerate), the shapshot and the MJPEG capture facilities.
>+agc, video framerate), the snapshot and the MJPEG capture facilities.
> 
> This interface consists of several ioctls (prototypes and structures
> can be found in include/linux/meye.h):
>-- 
>2.25.0.rc1
>
