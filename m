From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 2 Feb 2016 15:18:07 -0800
Subject: [Intel-wired-lan] [next PATCH v3 11/15] i40e/i40evf: Enable
 support for SKB_GSO_UDP_TUNNEL_CSUM
In-Reply-To: <20160202151000.00004aee@unknown>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051729.12004.54009.stgit@localhost.localdomain>
 <20160202144924.0000795d@unknown> <20160202151000.00004aee@unknown>
Message-ID: <20160202151807.0000708b@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2 Feb 2016 15:10:00 -0800
Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:

> On Tue, 2 Feb 2016 14:49:24 -0800
> Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:
> 
> And, isn't this patch missing the check that enables outer UDP only in
> the case of X722?
> 
> I expected to see an i40e_main.c change to tell the stack we support
> UDP_TUNNEL_CSUM only on X722.

Doh, I see it now in patch 13/15.
