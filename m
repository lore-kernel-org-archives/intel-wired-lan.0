From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 23 Dec 2015 23:09:33 +0000
Subject: [Intel-wired-lan] [next PATCH v2] ixgbe: Fix bugs
	in	ixgbe_clear_vf_vlans()
In-Reply-To: <20151223165946.30452.68020.stgit@localhost.localdomain>
References: <20151223165946.30452.68020.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CFBAF3@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, December 23, 2015 9:01 AM
> To: intel-wired-lan at lists.osuosl.org; alexander.duyck at gmail.com
> Subject: [Intel-wired-lan] [next PATCH v2] ixgbe: Fix bugs in
> ixgbe_clear_vf_vlans()
> 
> When I had rewritten the code for ixgbe_clear_vf_vlans() it looks like I had
> transitioned back and forth between using word as an offset and using word as a
> register offset.  As a result I honestly don't see how the code was working
> before other than the fact that resetting the VLANs on the VF like didn't do much
> to clear them.
> 
> Another issue found is that the mask was using a divide instead of a modulus.  As
> a result the mask bit was incorrectly being set to either bit
> 0 or 1 based on the value of the VF being tested.  As a result the wrong VFs were
> having their VLANs cleared if they were enabled.
> 
> I have updated the code so that word represents the offset in the array.
> This way we can use the modulus and xor operations and they will make sense
> instead of being performed on a 4 byte aligned value.
> 
> I replaced the statement "(word % 2) ^ 1" with "~word % 2" in order to reduce
> the line length as the line exceeded 80 characters with the register name
> inserted.  The two should be equivilent so the change should be safe.
> 
> Reported-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
