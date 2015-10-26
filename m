From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Oct 2015 18:35:53 +0000
Subject: [Intel-wired-lan] [next PATCH S19 06/15] i40e: Workaround fix
 for	mss < 256 issue
In-Reply-To: <1445471236-35918-7-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
 <1445471236-35918-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D3E89@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, October 21, 2015 4:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S19 06/15] i40e: Workaround fix for
> mss < 256 issue
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> HW/NVM sets a limit of no less than 256 bytes for MSS. Stack can send as low
> as 76 bytes MSS. This patch lowers the HW limit to 64 bytes to avoid MDDs
> from firing and causing a reset when the MSS is lower than 256.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I36b500a6bb227d283c3e321a7718e0672b11fab0
> 
> ---
> Testing-hints: 5644586
> Set the mss to as low as 76 bytes using iperf3:
> iperf3 -c 192.168.2.109 -B 192.168.2.108 -M 76 Check to see there are not
> resets and that the MSS for outbound packets is as was set by the test.
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 27
> +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, using iperf3 to pass traffic with MSS < 255 does not cause resets, MSS correctly set according to TShark capture, however attempting to set the MSS <88 causes an "Unable to set TCP MSS: invalid argument" error from iperf3 on the client side, and an "unable to set TCP/SCTP MSS: Bad file descriptor" on the server side.
