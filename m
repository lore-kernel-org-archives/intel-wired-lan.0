From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 17 Jun 2021 10:18:45 -0700
Subject: [Intel-wired-lan] mmotm 2021-06-16-22-12 uploaded
 (drivers/net/ethernet/intel/ice/ice_main.o)
In-Reply-To: <20210617051328.l8Tdz_iXt%akpm@linux-foundation.org>
References: <20210617051328.l8Tdz_iXt%akpm@linux-foundation.org>
Message-ID: <d288cd12-b095-b9fd-916a-66ad0cd60ce3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/16/21 10:13 PM, akpm at linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-06-16-22-12 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.


on i386:

ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_do_ioctl':
ice_main.c:(.text+0x66d): undefined reference to `ice_ptp_get_ts_config'
ld: ice_main.c:(.text+0x681): undefined reference to `ice_ptp_set_ts_config'
ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_rebuild':
ice_main.c:(.text+0x2213): undefined reference to `ice_ptp_init'
ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_remove':
ice_main.c:(.text+0x2623): undefined reference to `ice_ptp_release'
ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_prepare_for_reset':
ice_main.c:(.text+0x2813): undefined reference to `ice_ptp_release'
ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_misc_intr':
ice_main.c:(.text+0x4809): undefined reference to `ice_ptp_process_ts'
ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_probe':
ice_main.c:(.text+0x855b): undefined reference to `ice_ptp_init'
ld: drivers/net/ethernet/intel/ice/ice_txrx_lib.o: in function `ice_process_skb_fields':
ice_txrx_lib.c:(.text+0xdf): undefined reference to `ice_ptp_rx_hwtstamp'
ld: drivers/net/ethernet/intel/ice/ice_txrx.o: in function `ice_start_xmit':
ice_txrx.c:(.text+0x28e1): undefined reference to `ice_ptp_request_ts'
ld: drivers/net/ethernet/intel/ice/ice_ethtool.o: in function `ice_get_ts_info':
ice_ethtool.c:(.text+0x1ab5): undefined reference to `ice_get_ptp_clock_index'

Full randconfig file is attached.

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-r9975.gz
Type: application/gzip
Size: 32649 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210617/ab20ff29/attachment-0001.bin>
