From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 12 Oct 2016 20:41:18 +0000
Subject: [Intel-wired-lan] [PATCH v3] ixgbe: use link instead of
	I2C	combined abstraction
In-Reply-To: <20161010215403.27440.5694.stgit@localhost6.localdomain6>
References: <20161010215403.27440.5694.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E37730@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Emil Tantilov
Sent: Monday, October 10, 2016 2:54 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH v3] ixgbe: use link instead of I2C combined abstraction

Introduce ixgbe_link_operations struct with the following changes:

	read_i2c_combined		=> read_link
	read_i2c_combined_unlocked	=> read_link_unlocked
	write_i2c_combined		=> write_link
	write_i2c_combined_unlocked	=> write_link_unlocked

This will allow X550EM_a to override these methods for MDIO access while X550EM_x provides methods to use I2C combined access. This also adds a new structure, ixgbe_link_info, to hold information about the link. Initially this is just method pointers and a bus address.

The functions involved in combined I2C accesses were moved from ixgbe_phy.c to ixgbe_x550.c. The underlying functions that carry out the combined I2C accesses were left in ixgbe_phy.c because they share some functions with other I2C methods.

v2 - set hw->link.ops in probe.
v3 - check ii->link_ops before setting it since we don't have it for all devices.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

