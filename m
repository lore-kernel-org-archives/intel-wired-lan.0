From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 10 Dec 2021 08:16:54 -0800
Subject: [Intel-wired-lan] [PATCH v5 net-next 0/4] Add ethtool interface
 for RClocks
In-Reply-To: <20211210134550.1195182-1-maciej.machnikowski@intel.com>
References: <20211210134550.1195182-1-maciej.machnikowski@intel.com>
Message-ID: <20211210081654.233a41b6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 10 Dec 2021 14:45:46 +0100 Maciej Machnikowski wrote:
> Synchronous Ethernet networks use a physical layer clock to syntonize
> the frequency across different network elements.
> 
> Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
> Equipment Clock (EEC) and have the ability to synchronize to reference
> frequency sources.
> 
> This patch series is a prerequisite for EEC object and adds ability
> to enable recovered clocks in the physical layer of the netdev object.
> Recovered clocks can be used as one of the reference signal by the EEC.
> 
> Further work is required to add the DPLL subsystem, link it to the
> netdev object and create API to read the EEC DPLL state.

You missed CCing Vadim. I guess Ccing the right people may be right up
there with naming things as the hardest things in SW development..

Anyway, Vadim - do you have an ETA on the first chunk of the PLL work?
