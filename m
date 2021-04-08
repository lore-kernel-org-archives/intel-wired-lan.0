From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 8 Apr 2021 18:27:18 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: fix the restart
 auto-negotiation after FEC modified
In-Reply-To: <20210408122310.32752-1-mateusz.palczewski@intel.com>
References: <20210408122310.32752-1-mateusz.palczewski@intel.com>
Message-ID: <90008f14d0761219b77c3d18f7543c713d313759.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-04-08 at 12:23 +0000, Mateusz Palczewski wrote:
> From: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> 
> When FEC mode was changed the link didn't know it because
> the link was not reset and new parameters were not negotiated.
> Set a flag 'I40E_AQ_PHY_ENABLE_ATOMIC_LINK' in 'abilities'
> to restart the link and make it run with the new settings.
> 
> Fixes: 1d96340196f1 ("Add support FEC configuration for Fortville
> 25G")

The fixes is incorrect, it should match exactly don't drop anything.

Fixes: 1d96340196f1 ("i40e: Add support FEC configuration for Fortville
25G")

Please fix this up and resend.

> Signed-off-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
