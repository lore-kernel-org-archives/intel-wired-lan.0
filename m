From: Ken Cox <jkc@redhat.com>
Date: Tue, 14 Dec 2021 07:18:57 -0600
Subject: [Intel-wired-lan] [Patch 1/2] iavf: Fix panic in iavf_remove
In-Reply-To: <5da6e781833ce519a052754a68fde14d8477180b.camel@intel.com>
References: <20211208102153.669338-1-jkc@redhat.com>
 <20211208102153.669338-2-jkc@redhat.com>
 <5da6e781833ce519a052754a68fde14d8477180b.camel@intel.com>
Message-ID: <50c30d0c-213d-dd2f-1346-40f92fd315bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 12/13/21 12:26, Nguyen, Anthony L wrote:
> On Wed, 2021-12-08 at 04:21 -0600, Ken Cox wrote:
>> It's possible for the client_task to get scheduled by the watchdog
>> after cancel_delayed_work_sync(&adapter->client_task);? This can
>> cause
>> a panic because free_netdev() is called with the client_task still
>> queued
>> on the work queue.
>>
>> The stack backtrace usually looks similar to:
>>
>> [? 121.272963] Workqueue:? 0x0 (iavf)
>> [? 121.272969] RIP: 0010:__list_del_entry_valid.cold.1+0x20/0x4c
>> ...
>> [? 121.272980] Call Trace:
>> [? 121.272985]? move_linked_works+0x49/0xa0
>> [? 121.272988]? pwq_activate_delayed_work+0x43/0x100
>> [? 121.272991]? pwq_dec_nr_in_flight+0x5d/0x90
>> [? 121.272993]? worker_thread+0x30/0x370
>> [? 121.272995]? ? process_one_work+0x420/0x420
>> [? 121.272998]? kthread+0x15d/0x180
>> [? 121.273000]? ? __kthread_parkme+0xa0/0xa0
>> [? 121.273003]? ret_from_fork+0x1f/0x40
>>
>> Signed-off-by: Ken Cox <jkc@redhat.com>
>> ---
>>  ?drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
>>  ?1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
>> b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> index 6c2afbc8acbcd..63eec7edbf60a 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> @@ -3940,7 +3940,6 @@ static void iavf_remove(struct pci_dev *pdev)
>>  ????????set_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section);
>>  ????????cancel_delayed_work_sync(&adapter->init_task);
>>  ????????cancel_work_sync(&adapter->reset_task);
>> -???????cancel_delayed_work_sync(&adapter->client_task);
>>  ????????if (adapter->netdev_registered) {
>>  ????????????????unregister_netdev(netdev);
>>  ????????????????adapter->netdev_registered = false;
>> @@ -3974,6 +3973,7 @@ static void iavf_remove(struct pci_dev *pdev)
>>  ????????iavf_free_q_vectors(adapter);
>>   
>>  ????????cancel_delayed_work_sync(&adapter->watchdog_task);
>> +???????cancel_delayed_work_sync(&adapter->client_task);
>>   
>>  ????????cancel_work_sync(&adapter->adminq_task);
>>   
> 
> Hi Ken,
> 
> What tree is this patch based on? This doesn't apply to either of the
> IWL trees or the netdev trees.
Sorry, I was in the wrong branch when I generated these patches.  Please 
disregard.  I will re-evaluate and resend if necessary.

> 
> The ordering looks correct on the kernel tree with watchdog_task being
> cancelled before the client_task [1]. However, we do have an extra
> 'cancel_delayed_work_sync(&adapter->watchdog_task)'. I'll get a patch
> together to remove the extra one.
> 
> Thanks,
> Tony
> 
> 
> [1] https://elixir.bootlin.com/linux/v5.16-
> rc5/source/drivers/net/ethernet/intel/iavf/iavf_main.c#3979
> 

