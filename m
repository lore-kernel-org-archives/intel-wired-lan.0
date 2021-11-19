From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 19 Nov 2021 18:23:45 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix for displaying
 message regarding NVM version
In-Reply-To: <20211119124603.19611-1-mateusz.palczewski@intel.com>
References: <20211119124603.19611-1-mateusz.palczewski@intel.com>
Message-ID: <c066d91ca5a3b3f4323c6cd6c448a316dbb6a7ee.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-11-19 at 13:46 +0100, Mateusz Palczewski wrote:
> When loading the i40e driver, it prints a message like:
> 'The driver for the device detected a newer version of the NVM image
> v1.x than
> expected v1.y. Please install the most recent version of the network
> driver.'
> This is misleading as the driver is working as expected.
> 
> Fix that by removing the second part of message and changing it from
> dev_info to dev_dgb.
> 
> Fixes: 4fb29bddb ("i40e: The driver now prints the API version in
> error message")

This fixes is not formatted correctly:

Fixes tag: Fixes: 4fb29bddb ("i40e: The driver now prints the API
version in error message")
	Has these problem(s):
		- SHA1 should be at least 12 digits long
		  Can be fixed by setting core.abbrev to 12 (or more)
or (for git v2.11
		  or later) just making sure it is not set (or set to
"auto").

> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>

