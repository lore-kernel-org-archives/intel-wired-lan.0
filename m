From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 9 Mar 2018 19:14:53 +0100
Subject: [Intel-wired-lan] [PATCH 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
Message-ID: <20180309181453.GE27783@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Mar 09, 2018 at 09:21:33AM -0800, Anirudh Venkataramanan wrote:
> This patch implements a watchdog task to get packet statistics from
> the device.
> 
> This patch also adds support for the following ethtool operations:
> 
> ethtool devname
> ethtool -s devname [msglvl N] [msglevel type on|off]
> ethtool -g|--show-ring devname
> ethtool -G|--set-ring devname [rx N] [tx N]
> ethtool -i|--driver devname
> ethtool -d|--register-dump devname [raw on|off] [hex on|off] [file name]
> ethtool -k|--show-features|--show-offload devname
> ethtool -K|--features|--offload devname feature on|off
> ethtool -P|--show-permaddr devname
> ethtool -S|--statistics devname
> ethtool -a|--show-pause devname
> ethtool -A|--pause devname [autoneg on|off] [rx on|off] [tx on|off]
> ethtool -r|--negotiate devname
> ethtool --phy-statistics devname

Maybe i missed it, but i don't see any code for --phy-statistics?

      Andrew
