From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 4 Dec 2020 09:20:12 -0800
Subject: [Intel-wired-lan] [PATCH v2 bpf 0/5] New netdev feature flags
 for XDP
In-Reply-To: <20201204102901.109709-1-marekx.majtyka@intel.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
Message-ID: <20201204092012.720b53bf@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri,  4 Dec 2020 11:28:56 +0100 alardam at gmail.com wrote:
>  * Extend ethtool netlink interface in order to get access to the XDP
>    bitmap (XDP_PROPERTIES_GET). [Toke]

That's a good direction, but I don't see why XDP caps belong in ethtool
at all? We use rtnetlink to manage the progs...
