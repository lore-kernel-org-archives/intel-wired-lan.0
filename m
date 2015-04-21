From: Stefan Assmann <sassmann@kpanic.de>
Date: Tue, 21 Apr 2015 16:14:01 +0200
Subject: [Intel-wired-lan] VM guest bridging issue with i40e
Message-ID: <55365B29.6090609@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There's some trouble with a kvm guest that is bridged to the host
networks i40e (X710) NIC. The guest no longer receives DHCP replies and
probably other traffic as well.
I bisected this back to the following commit.
commit 79c21a827e98081895a8b9650f1b0a8b37b16125
Author: Anjali Singhai Jain <anjali.singhai@intel.com>
Date:   Thu Nov 13 03:06:14 2014 +0000

    i40e: Add new update VSI flow to accommodate FW fix with VSI Loopback mode

    All VSIs on a VEB should either have loopback enabled or disabled, a
    mixed mode is not supported for a VEB. Since our driver supports multiple
    VSIs per PF that need to talk to each other make sure to enable Loopback
    for the PF and FDIR VSI as well.

    Also, we now have to explicitly enable Loopback mode otherwise we fail
    VSI creation for VMDq and VF VSIs.

Reproducer:
Adding bridge on the host
# brctl addbr br0
# brctl addif br0 eth6
virt XML for bridging
    <interface type='bridge'>
      <source bridge='br0'/>
    </interface>
Now request IP via DHCP from the kvm guest.

The problem appears as soon as loopback gets enabled on the main VSI.
From the XL710 spec:
7.4.9.5.4.1.1 Add VSI Settings Recommendations
Table 7-86.  Add VSI Recommended settings
Allow Loopback 0 for PF

Is it correct that the main VSI represents the PF? If so shouldn't
loopback stay disabled for the main VSI?

  Stefan
