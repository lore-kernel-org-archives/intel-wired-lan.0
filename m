From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 7 Feb 2018 23:04:41 +0000
Subject: [Intel-wired-lan] [net-next] Documentation: Update Intel wired
 LAN docs
In-Reply-To: <20180206210029.27875-1-jeffrey.t.kirsher@intel.com>
References: <20180206210029.27875-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7E2ADD@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, February 6, 2018 1:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next] Documentation: Update Intel wired LAN
> docs
> 
> Updated the kernel documentation on e1000e, fm10k, i40e/vf, igb/vf and
> ixgbe/vf.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  Documentation/networking/e1000e.txt  |  436 ++++++++--------
>  Documentation/networking/fm10k.txt   |  389 +++++++++++++++
>  Documentation/networking/i40e.txt    |  906
> +++++++++++++++++++++++++++++-----
>  Documentation/networking/i40evf.txt  |  354 ++++++++++++-
>  Documentation/networking/igb.txt     |  282 ++++++++---
>  Documentation/networking/igbvf.txt   |   82 +--
>  Documentation/networking/ixgbe.txt   |  614 ++++++++++++++---------
>  Documentation/networking/ixgbevf.txt |   63 ++
>  8 files changed, 2378 insertions(+), 748 deletions(-)
>  create mode 100644 Documentation/networking/fm10k.txt
> 

Checkpatch has valid complaints about i40e.txt and i40evf.txt, for each one it says:
-------------------------------------------------------------------------------------------------------
ERROR: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#1901: FILE: Documentation/networking/i40e.txt:819:
+this program; if not, write to the Free Software Foundation, Inc., 51 Franklin$
-------------------------------------------------------------------------------------------------------
