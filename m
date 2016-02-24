From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 24 Feb 2016 12:22:44 -0800
Subject: [Intel-wired-lan] [PATCH v8 8/8] net: e1000e: Adds hardware
 supported cross timestamp on e1000e nic
In-Reply-To: <1456139726-3327-9-git-send-email-christopher.s.hall@intel.com>
References: <1456139726-3327-1-git-send-email-christopher.s.hall@intel.com>
 <1456139726-3327-9-git-send-email-christopher.s.hall@intel.com>
Message-ID: <1456345364.2808.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-02-22 at 03:15 -0800, Christopher S. Hall wrote:
> Modern Intel systems supports cross timestamping of the network
> device
> clock and Always Running Timer (ART) in hardware.? This allows the
> device time and system time to be precisely correlated. The timestamp
> pair is returned through e1000e_phc_get_syncdevicetime() used by
> get_system_device_crosststamp().? The hardware cross-timestamp result
> is made available to applications through the PTP_SYS_OFFSET_PRECISE
> ioctl which calls e1000e_phc_getcrosststamp().
> 
> Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
> [jstultz: Reworked to use new interface, commit message tweaks]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> ?drivers/net/ethernet/intel/Kconfig????????? |? 9 +++
> ?drivers/net/ethernet/intel/e1000e/defines.h |? 5 ++
> ?drivers/net/ethernet/intel/e1000e/ptp.c???? | 85
> +++++++++++++++++++++++++++++
> ?drivers/net/ethernet/intel/e1000e/regs.h??? |? 4 ++
> ?4 files changed, 103 insertions(+)

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160224/170bdcbc/attachment.asc>
