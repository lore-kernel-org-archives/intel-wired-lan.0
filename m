From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Tue, 28 May 2019 15:45:10 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 3/7] taprio: Add the
 skeleton to enable hardware offloading
In-Reply-To: <1559065608-27888-4-git-send-email-vedang.patel@intel.com>
References: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
 <1559065608-27888-4-git-send-email-vedang.patel@intel.com>
Message-ID: <20190528154510.41b50723@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 28 May 2019 10:46:44 -0700, Vedang Patel wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> This adds the UAPI and the core bits necessary for userspace to
> request hardware offloading to be enabled.
> 
> The future commits will enable hybrid or full offloading for taprio. This
> commit sets up the infrastructure to enable it via the netlink interface.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>

Other qdiscs offload by default, this offload-level selection here is a
little bit inconsistent with that :(

> @@ -731,6 +857,9 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
>  	if (err < 0)
>  		return err;
>  
> +	if (tb[TCA_TAPRIO_ATTR_OFFLOAD_FLAGS])
> +		offload_flags = nla_get_u32(tb[TCA_TAPRIO_ATTR_OFFLOAD_FLAGS]);

You should make sure user doesn't set unknown bits.  Otherwise using
other bits will not be possible in the future.

>  	new_admin = kzalloc(sizeof(*new_admin), GFP_KERNEL);
>  	if (!new_admin) {
>  		NL_SET_ERR_MSG(extack, "Not enough memory for a new schedule");
