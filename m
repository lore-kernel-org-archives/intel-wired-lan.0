From: Edward Cree <ecree@solarflare.com>
Date: Fri, 11 Sep 2020 18:26:29 +0100
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 11/11]
 drivers/net/ethernet: clean up mis-targeted comments
In-Reply-To: <20200911012337.14015-12-jesse.brandeburg@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-12-jesse.brandeburg@intel.com>
Message-ID: <227d2fe4-ddf8-89c9-b80b-142674c2cca0@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/09/2020 02:23, Jesse Brandeburg wrote:
> As part of the W=1 cleanups for ethernet, a million [1] driver comments
> had to be cleaned up to get the W=1 compilation to succeed. This
> change finally makes the drivers/net/ethernet tree compile with
> W=1 set on the command line.
>
> [1] - ok it wasn't quite a million, but it felt like it.
>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>
> ---
> @@ -263,6 +268,7 @@ struct efx_ptp_timeset {
>   * @nic_ts_enabled: Flag indicating if NIC generated TS events are handled
>   * @txbuf: Buffer for use when transmitting (PTP) packets to MC (avoids
>   *         allocations in main data path).
> + * @MC_CMD_PTP_IN_TRANSMIT_LENMAX: hack to get W=1 to compile
I think I'd rather have a bogus warning than bogus kerneldocto suppress it;
?please drop this line (and encourage toolchain folks to figure out how to
?get kerneldoc to ignore macros it can't understand).
Apart from that, the sfc and sfc/falcon parts LGTM.

-ed
