From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 1 Dec 2015 11:47:26 -0800
Subject: [Intel-wired-lan] [RFC 4/4] i40e: handle per queue rx_usecs
	setting
In-Reply-To: <1448956892-15509-4-git-send-email-kan.liang@intel.com>
References: <1448956892-15509-1-git-send-email-kan.liang@intel.com>
 <1448956892-15509-4-git-send-email-kan.liang@intel.com>
Message-ID: <20151201114726.43d0540c@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue,  1 Dec 2015 08:01:32 +0000
kan.liang at intel.com wrote:

> +u32 i40e_ndo_get_per_queue_rx_usecs(struct net_device *dev, int index)
> +{
> +	struct i40e_netdev_priv *np = netdev_priv(dev);
> +	struct i40e_vsi *vsi = np->vsi;
> +	struct i40e_pf *pf = vsi->back;
> +	struct i40e_hw *hw = &pf->hw;
> +	u32 val;
> +
> +	val = rd32(hw, I40E_PFINT_ITRN(0, index));
> +
> +	return (val * 2);

Please don't put useless paren's around return value.
That is a BSD style that is not practiced in Linux.
