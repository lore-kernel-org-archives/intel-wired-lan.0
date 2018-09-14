From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Fri, 14 Sep 2018 12:10:45 +0300
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 00/14] rename and
 shrink i40evf
In-Reply-To: <20180913223144.75823-1-jesse.brandeburg@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
Message-ID: <CAJ3xEMj3OXwz=A5+5JQ0mXoq2OU3N7DP-TpJVMtdTWXZw5tQ9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 14, 2018 at 1:31 AM, Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:

Hi Jesse,

> This series contains changes to i40evf so that it becomes a more
> generic virtual function driver for current and future silicon.
>
> While doing the rename of i40evf to a more generic name of iavf,
> we also put the driver on a severe diet due to how much of the
> code was unneeded or was unused.  The outcome is a lean and mean
> virtual function driver that continues to work on existing 40GbE
> (i40e) virtual devices and prepped for future supported devices,
> like the 100GbE (ice) virtual devices.

on what HW ring format do you standardize? do i40e/Fortville and
ice/what's-the-intel-code-name?  HWs can/use the same posting/completion
descriptor?

> This solves 2 issues we saw coming or were already present, the
> first was constant code duplication happening with i40e/i40evf,
> when much of the duplicate code in the i40evf was not used or was
> not needed.

could you spare few words on the origin/nature of these duplicates? were them
just developer C&P mistakes for functionality which is irrelevant for
a VF? like what?
if not, what was there?

> The second was to remove the future confusion of why
> future VF devices that were not considered "40GbE" only devices
> were supported by i40evf.

can elaborate further?

> The thought is that iavf will be the virtual function driver for
> all future devices, so it should have a "generic" name to propery
> represent that it is the VF driver for multiple generations of
> devices.

for that end,  as I think was explained @ the netdev Tokyo AVF session,
you would need a mechanism for feature negotiation, is it here or coming up?


>  41 files changed, 3436 insertions(+), 7581 deletions(-)

code diet is cool!
