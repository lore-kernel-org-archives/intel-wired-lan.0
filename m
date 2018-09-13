From: David Miller <davem@davemloft.net>
Date: Thu, 13 Sep 2018 15:43:23 -0700 (PDT)
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 00/14] rename and
 shrink i40evf
In-Reply-To: <20180913223144.75823-1-jesse.brandeburg@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
Message-ID: <20180913.154323.317381684393773865.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 13 Sep 2018 15:31:30 -0700

> This series contains changes to i40evf so that it becomes a more
> generic virtual function driver for current and future silicon.
> 
> While doing the rename of i40evf to a more generic name of iavf,
> we also put the driver on a severe diet due to how much of the
> code was unneeded or was unused.  The outcome is a lean and mean
> virtual function driver that continues to work on existing 40GbE
> (i40e) virtual devices and prepped for future supported devices,
> like the 100GbE (ice) virtual devices.
> 
> This solves 2 issues we saw coming or were already present, the
> first was constant code duplication happening with i40e/i40evf,
> when much of the duplicate code in the i40evf was not used or was
> not needed.  The second was to remove the future confusion of why
> future VF devices that were not considered "40GbE" only devices
> were supported by i40evf.
> 
> The thought is that iavf will be the virtual function driver for
> all future devices, so it should have a "generic" name to propery
> represent that it is the VF driver for multiple generations of
> devices.

Having a common vf driver for current and future devices is a major
accomplishment and I fully support these changes.

Nice work!

> Known Caveats:
> This may cause some user confusion, especially for Kconfig not
> migrating cleanly to the new CONFIG_IAVF from CONFIG_I40EVF.
> 
> Existing user configurations may have to change, but the module
> alias in patch 1 helps a bit here.

You can deal with this by retaining the existing I40EVF Kconfig
knob and just let it 'select' IAVF.
