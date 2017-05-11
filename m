From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 11 May 2017 11:27:49 -0700
Subject: [Intel-wired-lan] [PATCH net-next v3 00/14] i40e/i40evf: AVF
 series
In-Reply-To: <20170511182321.147850-1-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
Message-ID: <20170511112749.00000e65@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 11 May 2017 11:23:07 -0700
Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:
> v3: updated patch 4 to remove some unnecessary transforms to client
>     interface files, also had to update patch 9 to remove unused
>     I40E_QUEUE_ defines

Sorry for having to send a v3, we found a couple more issues with
changes that were not necessary related to client interface.
