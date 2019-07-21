From: David Miller <davem@davemloft.net>
Date: Sun, 21 Jul 2019 13:30:10 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] igc: Prefer
 pcie_capability_read_word()
In-Reply-To: <20190718020745.8867-4-fred@fredlawl.com>
References: <20190718020745.8867-1-fred@fredlawl.com>
 <20190718020745.8867-4-fred@fredlawl.com>
Message-ID: <20190721.133010.561994148836125357.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Frederick Lawler <fred@fredlawl.com>
Date: Wed, 17 Jul 2019 21:07:39 -0500

> Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
> added accessors for the PCI Express Capability so that drivers didn't
> need to be aware of differences between v1 and v2 of the PCI
> Express Capability.
> 
> Replace pci_read_config_word() and pci_write_config_word() calls with
> pcie_capability_read_word() and pcie_capability_write_word().
> 
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>

Applied.
