From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 14 Apr 2021 21:36:18 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: fix the restart
 auto-negotiation after FEC modified
In-Reply-To: <20210413141940.3456-1-mateusz.palczewski@intel.com>
References: <20210413141940.3456-1-mateusz.palczewski@intel.com>
Message-ID: <4b49fd986e95b5c3c46cd244a6f8166b23654062.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-04-13 at 14:19 +0000, Mateusz Palczewski wrote:
> From: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> 
> When FEC mode was changed the link didn't know it because
> the link was not reset and new parameters were not negotiated.
> Set a flag 'I40E_AQ_PHY_ENABLE_ATOMIC_LINK' in 'abilities'
> to restart the link and make it run with the new settings.
> 
> Fixes: 1d96340196f1 ("i40e: Add support FEC configuration for
> Fortville
> 25G")

I've fixed this up but please note that the tag should not be wrapped.

"Do not split the tag across multiple lines, tags are exempt from the
wrap at 75 columns rule in order to simplify parsing scripts."

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> Signed-off-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
