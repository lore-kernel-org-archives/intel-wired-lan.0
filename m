From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 03 Nov 2020 15:41:00 -0800
Subject: [Intel-wired-lan] [PATCH v3 9/9] igc: Add support for
 XDP_REDIRECT action
In-Reply-To: <20201102183007.GL6427@ranger.igk.intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
 <20201030210351.46482-10-andre.guedes@intel.com>
 <20201102183007.GL6427@ranger.igk.intel.com>
Message-ID: <160444686030.10323.16059007261881463636@anemani-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Maciej Fijalkowski (2020-11-02 10:30:07)
> On Fri, Oct 30, 2020 at 02:03:51PM -0700, Andre Guedes wrote:
> > This patch adds support for the XDP_REDIRECT action which enables XDP
> > programs to redirect packets arriving at I225 NIC. It also implements
> > the ndo_xdp_xmit ops, enabling the igc driver to transmit packets
> > forwarded to it by xdp programs running on other interfaces.
> > 
> > The patch tweaks the driver's page counting scheme (as described in
> > '8ce29c679a6e i40e: tweak page counting for XDP_REDIRECT' and
> > implemented by other Intel drivers) in order to properly support
> > XDP_REDIRECT action.
> > 
> > This patch has been tested with the sample apps "xdp_redirect_cpu" and
> > "xdp_redirect_map" located in samples/bpf/.
> 
> Did you test in a way that the igc interface was the second interface for
> redirect samples and you checked that tx happened?

I tested both ways with xdp_redirect_map i.e. igc interface as the IFNAME_IN
and as the IFNAME_OUT arguments.
