From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 20 Jan 2022 22:11:48 +0000
Subject: [Intel-wired-lan] [PATCH net v4] iavf: Fix handling of vlan
 strip virtual channel messages
In-Reply-To: <20220120134534.183322-1-michal.maloszewski@intel.com>
References: <20220120134534.183322-1-michal.maloszewski@intel.com>
Message-ID: <5c08a2fd8add4ca4c9c15721ce14e342a053adc8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2022-01-20 at 13:45 +0000, Michal Maloszewski wrote:
> Modify netdev->features for vlan stripping based on virtual
> channel messages received from the PF. Change is needed
> to synchronize vlan strip status between PF sysfs and iavf ethtool.
> 
> Fixes: 5961a2b9812d ("iavf: Fix VLAN feature flags after VFR")

This fixes tag needs some work:

Fixes tag: Fixes: 5961a2b9812d ("iavf: Fix VLAN feature flags after
VFR")
	Has these problem(s):
		- Target SHA1 does not exist


> Signed-off-by: Norbert Ciosek <norbertx.ciosek@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>

