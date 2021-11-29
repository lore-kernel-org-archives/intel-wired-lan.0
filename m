From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Mon, 29 Nov 2021 15:10:47 +0100
Subject: [Intel-wired-lan] [PATCH net-next 0/2] igc: driver change to
 support XDP metadata
In-Reply-To: <163700856423.565980.10162564921347693758.stgit@firesoul>
References: <163700856423.565980.10162564921347693758.stgit@firesoul>
Message-ID: <20211129141047.8939-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Mon, 15 Nov 2021 21:36:20 +0100

> Changes to fix and enable XDP metadata to a specific Intel driver igc.
> Tested with hardware i225 that uses driver igc, while testing AF_XDP
> access to metadata area.

Would you mind if I take this your series into my bigger one that
takes care of it throughout all the Intel drivers?

> ---
> 
> Jesper Dangaard Brouer (2):
>       igc: AF_XDP zero-copy metadata adjust breaks SKBs on XDP_PASS
>       igc: enable XDP metadata in driver
> 
> 
>  drivers/net/ethernet/intel/igc/igc_main.c |   33 +++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> --

Thanks,
Al
