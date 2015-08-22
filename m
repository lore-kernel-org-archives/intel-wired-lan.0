From: Jesse Gross <jesse@nicira.com>
Date: Fri, 21 Aug 2015 17:38:42 -0700
Subject: [Intel-wired-lan] [PATCH 4/4] i40e: geneve tunnel offload
	support
In-Reply-To: <1440096383-8915-4-git-send-email-anjali.singhai@intel.com>
References: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
 <1440096383-8915-4-git-send-email-anjali.singhai@intel.com>
Message-ID: <CAEP_g=_2fP2oKfEd6-eN0TF7q1bWFULzJu7rgSZGJS=-DeomGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Aug 20, 2015 at 11:46 AM, Anjali Singhai Jain
<anjali.singhai@intel.com> wrote:
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index bbc704b..7b41e1a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -6665,7 +6665,7 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
>   **/
>  static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
>  {
> -#if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE)
> +#if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE) || defined(CONFIG_GENEVE_CORE)

Presumably this also needs CONFIG_GENEVE_CORE_MODULE (or use IS_ENABLED).
