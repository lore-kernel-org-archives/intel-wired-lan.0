From: Andre Guedes <andre.guedes@linux.intel.com>
Date: Thu, 09 Apr 2020 10:51:09 -0700
Subject: [Intel-wired-lan] [PATCH v4] igc: add support to interrupt,
 eeprom, registers and link self-tests
In-Reply-To: <20200405121604.36654-1-vitaly.lifshits@intel.com>
References: <20200405121604.36654-1-vitaly.lifshits@intel.com>
Message-ID: <158645466999.55760.14738986034336933984@pbarlowx-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Introduced igc_diag.c and igc_diag.h, these files have the
> diagnostics functionality of igc driver. For the time being
> these files are being used by ethtool self-test callbacks.
> Which mean that interrupt, eeprom, registers and link self-tests for
> ethtool were implemented.
> 
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Andre Guedes <andre.guedes@intel.com>
