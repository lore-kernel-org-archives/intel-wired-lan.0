From: Edward Cree <ecree@solarflare.com>
Date: Tue, 15 Sep 2020 10:05:59 +0100
Subject: [Intel-wired-lan] [PATCH net-next v2 09/10] sfc: fix kdoc
 warning
In-Reply-To: <20200915014455.1232507-10-jesse.brandeburg@intel.com>
References: <20200915014455.1232507-1-jesse.brandeburg@intel.com>
 <20200915014455.1232507-10-jesse.brandeburg@intel.com>
Message-ID: <aaa15cdb-179b-bca7-6d41-4a861aaa3470@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 15/09/2020 02:44, Jesse Brandeburg wrote:
> kernel-doc script as used by W=1, is confused by the macro
> usage inside the header describing the efx_ptp_data struct.
>
> drivers/net/ethernet/sfc/ptp.c:345: warning: Function parameter or member 'MC_CMD_PTP_IN_TRANSMIT_LENMAX' not described in 'efx_ptp_data'
>
> After some discussion on the list, break this patch out to
> a separate one, and fix the issue through a creative
> macro declaration.
>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Edward Cree <ecree@solarflare.com>
I still don't love it, but it'll do, so have an
Acked-by: Edward Cree <ecree@solarflare.com>

(But please make sure whoever maintains scripts/kernel-doc knows that
?it's breaking on a reasonable construct and forcing the code to be
?_less_ self-documenting than it otherwise could be.)
