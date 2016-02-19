From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 18 Feb 2016 16:43:23 -0800
Subject: [Intel-wired-lan] [PATCH v7 8/8] net: e1000e: Adds hardware
 supported cross timestamp on e1000e nic
In-Reply-To: <1455308729-6280-9-git-send-email-christopher.s.hall@intel.com>
References: <1455308729-6280-1-git-send-email-christopher.s.hall@intel.com>
 <1455308729-6280-9-git-send-email-christopher.s.hall@intel.com>
Message-ID: <1455842603.3128.61.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-02-12 at 12:25 -0800, Christopher S. Hall wrote:
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

I am fine with Christopher's changes, so when the issues with the other
patches in the series gets ironed out, your good to apply this patch as
well John.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160218/680a0772/attachment.asc>
