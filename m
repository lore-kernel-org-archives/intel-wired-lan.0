From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 23 May 2019 15:55:15 -0700
Subject: [Intel-wired-lan] [RESEND PATCH] intel-ethernet: warn when
 fatal read failure happens
In-Reply-To: <20190523032233.29277-1-feng.tang@intel.com>
References: <20190523032233.29277-1-feng.tang@intel.com>
Message-ID: <f8d774415fcb66c46ebc08a9b66f32d825c004ac.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-05-23 at 11:22 +0800, Feng Tang wrote:
> Failed in reading the HW register is very serious for igb/igc driver,
> as its hw_addr will be set to NULL and cause the adapter be seen as
> "REMOVED".
> 
> We saw the error only a few times in the MTBF test for
> suspend/resume,
> but can hardly get any useful info to debug.
> 
> Adding WARN() so that we can get the necessary information about
> where and how it happens, and use it for root causing and fixing
> this "PCIe link lost issue"
> 
> This affects igb, igc.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> Acked-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 +
>  2 files changed, 2 insertions(+)

This patch is already in my next series of 1GbE patches to push to
Dave, so you can expect this to be pushed upstream before the weekend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190523/c6977fef/attachment.asc>
