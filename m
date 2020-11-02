From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 2 Nov 2020 19:30:07 +0100
Subject: [Intel-wired-lan] [PATCH v3 9/9] igc: Add support for
 XDP_REDIRECT action
In-Reply-To: <20201030210351.46482-10-andre.guedes@intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
 <20201030210351.46482-10-andre.guedes@intel.com>
Message-ID: <20201102183007.GL6427@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 30, 2020 at 02:03:51PM -0700, Andre Guedes wrote:
> This patch adds support for the XDP_REDIRECT action which enables XDP
> programs to redirect packets arriving at I225 NIC. It also implements
> the ndo_xdp_xmit ops, enabling the igc driver to transmit packets
> forwarded to it by xdp programs running on other interfaces.
> 
> The patch tweaks the driver's page counting scheme (as described in
> '8ce29c679a6e i40e: tweak page counting for XDP_REDIRECT' and
> implemented by other Intel drivers) in order to properly support
> XDP_REDIRECT action.
> 
> This patch has been tested with the sample apps "xdp_redirect_cpu" and
> "xdp_redirect_map" located in samples/bpf/.

Did you test in a way that the igc interface was the second interface for
redirect samples and you checked that tx happened?

> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
