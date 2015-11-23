From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Sun, 22 Nov 2015 23:03:38 -0800
Subject: [Intel-wired-lan] [PATCH 0/6] Generalize udp based tunnels and add
	geneve offload
In-Reply-To: <anjali.singhai@intel.com>
References: <anjali.singhai@intel.com>
Message-ID: <1448262224-71480-1-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series generalizes the flow for udp_based tunnels for
offload hooks. So that much of the frame work can remain common
for any driver adding support for geneve or any other
udp_based tunnel in future.

This patch series also makes the driver calls to/from the stack
independent of the tunnel modules. So it would be easier to remove
module config parameters from the respective drivers for tunnel
support. One such example is in i40e driver.

This patch series also adds support for geneve offload in i40e driver.

Much thanks to Jesse Gross for his valuable feedback in getting this
done the right way.

Anjali Singhai Jain (6):
net: Generalize udp based tunnel offload
net: Add a generic udp_offload_get_port function
i40e: Generalize the flow for udp based tunnels
i40e: Remove CONFIG_I40E_VXLAN
net: Refactor udp_offload and add Geneve port offload
i40e:Add geneve tunnel offload support
