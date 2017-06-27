From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 27 Jun 2017 01:21:59 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: e1000e: add check
	on	e1e_wphy() return value
In-Reply-To: <20170620212234.GA10957@embeddedgus>
References: <20170518172223.Horde.5kLLwxMJWThQKv0bAxTsk4D@gator4166.hostgator.com>
 <20170620212234.GA10957@embeddedgus>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6251E1@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Gustavo A. R. Silva
> Sent: Tuesday, June 20, 2017 2:23 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Gustavo A. R. Silva <garsilva@embeddedor.com>
> Subject: [Intel-wired-lan] [PATCH] net: intel: e1000e: add check on
> e1e_wphy() return value
> 
> Check return value from call to e1e_wphy(). This value is being
> checked during previous calls to function e1e_wphy() and it seems
> a check was missing here.
> 
> Addresses-Coverity-ID: 1226905
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
