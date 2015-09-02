From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:01:05 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: Report MAC address on
 driver	load
In-Reply-To: <20150619023812.1345.75383.stgit@ahduyck-vm-fedora22>
References: <20150619023812.1345.75383.stgit@ahduyck-vm-fedora22>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B5392@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Thursday, June 18, 2015 7:41 PM
To: netdev@vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Subject: [Intel-wired-lan] [PATCH v2] fm10k: Report MAC address on driver load

This change adds the MAC address to the list of values recorded on driver load.  The MAC address represents the serial number of the unit and allows us to track the value should a card be replaced in a system.

The log message should now be similar in output to that of ixgbe.

Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
---

Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
