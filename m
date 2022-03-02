From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 2 Mar 2022 11:15:25 +0000
Subject: [Intel-wired-lan] [net-next PATCH 04/25] ice: convert
 vf->vc_ops to a const pointer
In-Reply-To: <20220223002712.2771809-5-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-5-jacob.e.keller@intel.com>
Message-ID: <MW3PR11MB4554249B9AA483646E83C1919C039@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Jacob Keller
>Sent: Wednesday, February 23, 2022 5:57 AM
>To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
>Subject: [Intel-wired-lan] [net-next PATCH 04/25] ice: convert vf->vc_ops to a
>const pointer
>
>The vc_ops structure is used to allow different handlers for virtchnl
>commands when the driver is in representor mode. The current
>implementation uses a copy of the ops table in each VF, and modifies this
>copy dynamically.
>
>The usual practice in kernel code is to store the ops table in a constant
>structure and point to different versions. This has a number of
>advantages:
>
>  1. Reduced memory usage. Each VF merely points to the correct table,
>     so they're able to re-use the same contsnat lookup table in memory.
>  2. Consistency. It becomes more difficult to accidentally update or
>     edit only one op call. Instead, the code switches to the correct
>     able by a single pointer write. In general this is atomic, either
>     the pointer is updated or its not.
>  3. Code Layout. The VF structure can store a pointer to the table
>     without needing to have the full structure definition defined prior
>     to the VF structure definition. This will aid in future refactoring
>     of code by allowing the VF pointer to be kept in ice_vf_lib.h while
>     the virtchnl ops table can be maintained in ice_virtchnl.h
>
>There is one major downside in the case of the vc_ops structure. Most of the
>operations in the table are the same between the two current
>implementations. This can appear to lead to duplication since each
>implementation must now fill in the complete table. It could make spotting the
>differences in the representor mode more challenging.
>Unfortunately, methods to make this less error prone either add complexity
>overhead (macros using CPP token concatenation) or don't work on all
>compilers we support (constant initializer from another constant structure).
>
>The cost of maintaining two structures does not out weigh the benefits of the
>constant table model.
>
>While we're making these changes, go ahead and rename the structure and
>implementations with "virtchnl" instead of "vc_vf_". This will more closely
>align with the planned file renaming, and avoid similar names when we later
>introduce a "vf ops" table for separating Scalable IOV and Single Root IOV
>implementations.
>
>Leave the accessor/assignment functions in order to avoid issues with
>compiling with options disabled. The interface makes it easier to handle when
>CONFIG_PCI_IOV is disabled in the kernel.
>
>Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_repr.c  |  4 +-
>drivers/net/ethernet/intel/ice/ice_sriov.c | 61 +++++++++++++++++-----
>drivers/net/ethernet/intel/ice/ice_sriov.h | 13 +++--
> 3 files changed, 55 insertions(+), 23 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
