From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Mon, 24 Jun 2019 14:40:13 -0700
Subject: [Intel-wired-lan] [PATCH net-next v5 2/7] etf: Add
 skip_sock_check
In-Reply-To: <1561138108-12943-3-git-send-email-vedang.patel@intel.com>
References: <1561138108-12943-1-git-send-email-vedang.patel@intel.com>
 <1561138108-12943-3-git-send-email-vedang.patel@intel.com>
Message-ID: <20190624144013.3168dde2@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 21 Jun 2019 10:28:23 -0700, Vedang Patel wrote:
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
> index 8b2f993cbb77..409d1616472d 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -990,6 +990,7 @@ struct tc_etf_qopt {
>  	__u32 flags;
>  #define TC_ETF_DEADLINE_MODE_ON	BIT(0)
>  #define TC_ETF_OFFLOAD_ON	BIT(1)
> +#define TC_ETF_SKIP_SOCK_CHECK	BIT(2)
>  };
>  
>  enum {

I think build bot complained about the code not building on 32bit.
When you respin could you include a patch to remove the uses of BIT()
in UAPI?  See: https://www.spinics.net/lists/netdev/msg579344.html
