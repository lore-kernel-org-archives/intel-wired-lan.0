From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 18 Jun 2015 19:23:48 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: Report MAC address on driver
 load
In-Reply-To: <1434671381.3530.81.camel@intel.com>
References: <20150618031252.15654.56639.stgit@ahduyck-vm-fedora22>
 <1434671381.3530.81.camel@intel.com>
Message-ID: <55837D34.7070100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/18/2015 04:49 PM, Jeff Kirsher wrote:
> On Wed, 2015-06-17 at 20:12 -0700, Alexander Duyck wrote:
>> This change adds the MAC address to the list of values recorded on
>> driver
>> load.  The MAC address represents the serial number of the unit and
>> allows
>> us to track the value should a card be replaced in a system.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/fm10k/fm10k_pci.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> With the recent fm10k patches that Jake submitted, this patch no longer
> applies cleanly.  If you could re-spin your patch against my next-queue
> tree (dev-queue branch) that would be much appreciated.

I should have a new patch for you in 20 minutes or so.  Just waiting on 
the build to finish and then I'll give it a quick test.

- Alex
