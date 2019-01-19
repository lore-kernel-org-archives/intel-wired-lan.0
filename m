From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 19 Jan 2019 02:36:24 +0000
Subject: [Intel-wired-lan] [PATCH v2] e1000e: fix a missing check for
 return value
In-Reply-To: <20190104011703.11365-1-jeffrey.t.kirsher@intel.com>
References: <20190104011703.11365-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9661A7BA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, January 3, 2019 5:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kangjie Lu <kjlu@umn.edu>
> Subject: [Intel-wired-lan] [PATCH v2] e1000e: fix a missing check for return
> value
> 
> The change is based on the issue found by Kangjie Lu <kjlu@umn.edu>
> where
> we not checking the return value of a register read/write which could result
> in a NULL pointer dereference if the read/write fails.
> 
> Since we are only trying to disable the far-end loopback, if the read
> and write of register fails, we do not want to bail out of the function.
> We just want to log that it failed to disable and continue on.
> 
> CC: Sasha Neftin <sasha.neftin@intel.com>
> CC: Kangjie Lu <kjlu@umn.edu>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> v2: fixed a compilation error due to me fat fingering missing braces.
> 
>  .../net/ethernet/intel/e1000e/80003es2lan.c   | 33 +++++++++++++------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 

Tested-by: Aaron Brown <aaron .f.brown@intel.com>
