From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Sun, 21 Nov 2021 12:33:23 +0200
Subject: [Intel-wired-lan] [PATCH net-next 2/2] igc: enable XDP metadata
 in driver
In-Reply-To: <163700859087.565980.3578855072170209153.stgit@firesoul>
References: <163700856423.565980.10162564921347693758.stgit@firesoul>
 <163700859087.565980.3578855072170209153.stgit@firesoul>
Message-ID: <a991d408-df9e-4a4a-1887-8973553adb23@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/15/2021 22:36, Jesper Dangaard Brouer wrote:
> Enabling the XDP bpf_prog access to data_meta area is a very small
> change. Hint passing 'true' to xdp_prepare_buff().
> 
> The SKB layers can also access data_meta area, which required more
> driver changes to support. Reviewers, notice the igc driver have two
> different functions that can create SKBs, depending on driver config.
> 
> Hint for testers, ethtool priv-flags legacy-rx enables
> the function igc_construct_skb()
> 
>   ethtool --set-priv-flags DEV legacy-rx on
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c |   29 +++++++++++++++++++----------
>   1 file changed, 19 insertions(+), 10 deletions(-)
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>




