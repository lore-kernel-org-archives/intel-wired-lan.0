From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 10 Dec 2015 10:47:37 -0800
Subject: [Intel-wired-lan] [next PATCH S23 08/13] i40e: define function
 capabilities in only one place
In-Reply-To: <1449705033-4968-9-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
 <1449705033-4968-9-git-send-email-joshua.a.hay@intel.com>
Message-ID: <20151210104737.00004708@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 9 Dec 2015 15:50:28 -0800
Joshua Hay <joshua.a.hay@intel.com> wrote:

> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> The device capabilities were defined in two places, and neither had all
> the definitions.  It really belongs with the AQ API definition, so this
> patch removes the other set of definitions and fills out the missing item.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Only the Author's S.O.B should be included when submitting upstream,
until Jeff adds his own S.O.B as part of the upstreaming process.

