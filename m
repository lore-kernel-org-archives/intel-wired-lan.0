From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 11 Mar 2021 19:27:30 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix autoneg disabling
 for non-10GBaseT links
In-Reply-To: <20210310111254.7610-1-mateusz.palczewski@intel.com>
References: <20210310111254.7610-1-mateusz.palczewski@intel.com>
Message-ID: <678fa0dee1a3fb7d276905165ac186212571ef37.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-03-10 at 11:12 +0000, Mateusz Palczewski wrote:
> Disabling autonegotiation was allowed only for 10GBaseT PHY.
> The condition was changed to check if link media type is BaseT.
> 
> Fixes: 3ce12ee9d8f9("i40e: Fix order of checks when
> enabling/disabling autoneg in ethtool")

This is missing a space after the hash

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Karen Sornek <karen.sornek@intel.com>
> Signed-off-by: Dawid Lukwinski <dawid.lukwinski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
