From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 24 Nov 2015 21:39:23 -0800
Subject: [Intel-wired-lan] [RFC PATCH V2 3/3] Ixgbevf: Add migration
	support for ixgbevf driver
In-Reply-To: <20151124230551-mutt-send-email-mst@redhat.com>
References: <1448372298-28386-1-git-send-email-tianyu.lan@intel.com>
 <1448372298-28386-4-git-send-email-tianyu.lan@intel.com>
 <20151124230551-mutt-send-email-mst@redhat.com>
Message-ID: <CAKgT0UcTHPfX7wh_niV=nP14hU5N44sRuKmVrMcSSc_DqYPXrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 24, 2015 at 1:20 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Nov 24, 2015 at 09:38:18PM +0800, Lan Tianyu wrote:
>> This patch is to add migration support for ixgbevf driver. Using
>> faked PCI migration capability table communicates with Qemu to
>> share migration status and mailbox irq vector index.
>>
>> Qemu will notify VF via sending MSIX msg to trigger mailbox
>> vector during migration and store migration status in the
>> PCI_VF_MIGRATION_VMM_STATUS regs in the new capability table.
>> The mailbox irq will be triggered just befoe stop-and-copy stage
>> and after migration on the target machine.
>>
>> VF driver will put down net when detect migration and tell
>> Qemu it's ready for migration via writing PCI_VF_MIGRATION_VF_STATUS
>> reg. After migration, put up net again.
>>
>> Qemu will in charge of migrating PCI config space regs and MSIX config.
>>
>> The patch is to dedicate on the normal case that net traffic works
>> when mailbox irq is enabled. For other cases(such as the driver
>> isn't loaded, adapter is suspended or closed), mailbox irq won't be
>> triggered and VF driver will disable it via PCI_VF_MIGRATION_CAP
>> reg. These case will be resolved later.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>
> I have to say, I was much more interested in the idea
> of tracking dirty memory. I have some thoughts about
> that one - did you give up on it then?

The tracking of dirty pages still needs to be addressed unless the
interface is being downed before migration even starts which based on
other comments I am assuming is not the case.

I still feel that having a means of marking a page as being dirty when
it is unmapped would be the best way to go.  That way you only have to
update the DMA API instead of messing with each and every driver
trying to add code to force the page to be dirtied.

- Alex
