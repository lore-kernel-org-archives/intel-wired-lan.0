From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Mon, 27 Aug 2018 11:31:09 +0300
Subject: [Intel-wired-lan] [PATCH v6 04/11] igc: Add interrupt support
In-Reply-To: <fc18c378-98f1-a311-a5ac-270a754b82f7@oracle.com>
References: <20180823070600.12369-1-sasha.neftin@intel.com>
 <fc18c378-98f1-a311-a5ac-270a754b82f7@oracle.com>
Message-ID: <1758ed20-e722-f9fe-19c1-6fb2c9b471f2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/23/2018 19:37, Shannon Nelson wrote:
> On 8/23/2018 12:06 AM, Sasha Neftin wrote:
> 
> [...]
> 
>> +
>> +/**
>> + *? igc_request_msix - Initialize MSI-X interrupts
>> + *? @adapter: Pointer to adapter structure
>> + *
>> + *? igc_request_msix allocates MSI-X vectors and requests interrupts 
>> from the
>> + *? kernel.
>> + **/
>> +static int igc_request_msix(struct igc_adapter *adapter)
>> +{
>> +??? int i = 0, err = 0, vector = 0, free_vector = 0;
>> +??? struct net_device *netdev = adapter->netdev;
>> +
>> +??? err = request_irq(adapter->msix_entries[vector].vector,
>> +????????????? &igc_msix_other, 0, netdev->name, adapter);
>> +??? if (err)
>> +??????? goto err_out;
>> +
>> +??? for (i = 0; i < adapter->num_q_vectors; i++) {
>> +??????? struct igc_q_vector *q_vector = adapter->q_vector[i];
>> +
>> +??????? vector++;
>> +
>> +??????? q_vector->itr_register = adapter->io_addr + IGC_EITR(vector);
>> +
>> +??????? if (q_vector->rx.ring && q_vector->tx.ring)
>> +??????????? sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
>> +??????????????? q_vector->rx.ring->queue_index);
>> +??????? else if (q_vector->tx.ring)
>> +??????????? sprintf(q_vector->name, "%s-tx-%u", netdev->name,
>> +??????????????? q_vector->tx.ring->queue_index);
>> +??????? else if (q_vector->rx.ring)
>> +??????????? sprintf(q_vector->name, "%s-rx-%u", netdev->name,
>> +??????????????? q_vector->rx.ring->queue_index);
>> +??????? else
>> +??????????? sprintf(q_vector->name, "%s-unused", netdev->name);
>> +
>> +??????? err = request_irq(adapter->msix_entries[vector].vector,
>> +????????????????? igc_msix_ring, 0, q_vector->name,
>> +????????????????? q_vector);
>> +??????? if (err)
>> +??????????? goto err_free;
>> +??? }
>> +
>> +??? igc_configure_msix(adapter);
>> +??? return 0;
>> +
>> +err_free:
>> +??? /* free already assigned IRQs */
>> +??? free_irq(adapter->msix_entries[free_vector++].vector, adapter);
>> +
>> +??? vector--;
> 
> You might set free_vector to 0 here rather than in the definition above, 
> just in case someone in the future decides to use it elsewhere in the 
> function and leave junk in it.
> 
i will consult with my colleagues about this suggestion.
>> +??? for (i = 0; i < vector; i++) {
>> +??????? free_irq(adapter->msix_entries[free_vector++].vector,
>> +???????????? adapter->q_vector[i]);
>> +??? }
>> +err_out:
>> +??? return err;
>> +}
>> +
> 
> [...]
> 
>> +
>> +??? /*populate entry values*/
> 
> Fix comment spacing
> 
I need to fix that. Thanks.
> sln

