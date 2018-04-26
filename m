From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 26 Apr 2018 11:23:34 -0700
Subject: [Intel-wired-lan] [PATCH v2] ixgbe/ixgbevf: Fix free irq
 process when removing device due to PCI Errors
In-Reply-To: <20180426163342.GA14851@korriban>
References: <1524688281-12930-1-git-send-email-maurosr@linux.vnet.ibm.com>
 <CAKgT0Uc+MgMmPaUS3USLNudOFNk39wmYW-LqmAgzoNqaXE0qYg@mail.gmail.com>
 <20180426163342.GA14851@korriban>
Message-ID: <CAKgT0Uf0evZrzLA7aShXkH8CrDOyxuouLpPG+2gUbWXh7Xa0SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 26, 2018 at 9:33 AM, Mauro Rodrigues
<maurosr@linux.vnet.ibm.com> wrote:
> On Wed, Apr 25, 2018 at 01:56:48PM -0700, Alexander Duyck wrote:
>> On Wed, Apr 25, 2018 at 1:31 PM, Mauro S. M. Rodrigues
>> <maurosr@linux.vnet.ibm.com> wrote:
>> > When a PCI error is detected ixgbe's pci error handler
>> > ixgbe_io_error_detected detaches the network device. In general the PCI
>> > error recovery mechanism may try to recover the device from the error or
>> > eventually remove it completely from the system.
>> >
>> > Since commit f7f37e7ff2b9 ("ixgbe: handle close/suspend race with
>> > netif_device_detach/present")
>> > we only follow to ixgbe_close_suspend if
>> > the device is preset, i.e. if it wasn't detached, and then the irqs are
>> > freed. That prevents to free irqs when the PCI error recovery system
>> > decides to remove the device and hitting a BUG_ON free_msi_irqs when it
>> > search for non freed irqs associated with the device being removed:
>> >
>> > BUG_ON(irq_has_action(entry->irq + i));
>> >
>> > This is fixed allowing the ixgbe_close_suspend, and thus ixgbe_free_irq,
>> > to be called also when the PCI error recovery mechanism sets the device
>> > channel to permanent failure state.
>> >
>> > Reported-by: Naresh Bannoth <nbannoth@in.ibm.com>
>> > Reported-by: Abdul Haleem <abdhalee@in.ibm.com>
>> > Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
>> > ---
>> > v2: Extended the fix to ixgbevf driver.
>> >
>> > ---
>> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 3 ++-
>> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 3 ++-
>> >  2 files changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> > index afadba9..d170de8 100644
>> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> > @@ -6679,7 +6679,8 @@ int ixgbe_close(struct net_device *netdev)
>> >
>> >         ixgbe_ptp_stop(adapter);
>> >
>> > -       if (netif_device_present(netdev))
>> > +       if (netif_device_present(netdev) ||
>> > +           adapter->pdev->error_state == pci_channel_io_perm_failure)
>> >                 ixgbe_close_suspend(adapter);
>> >
>> >         ixgbe_fdir_filter_exit(adapter);
>> > diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>> > index 3d9033f..f916dc5 100644
>> > --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>> > +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>> > @@ -3661,7 +3661,8 @@ int ixgbevf_close(struct net_device *netdev)
>> >  {
>> >         struct ixgbevf_adapter *adapter = netdev_priv(netdev);
>> >
>> > -       if (netif_device_present(netdev))
>> > +       if (netif_device_present(netdev) ||
>> > +               adapter->pdev->error_state == pci_channel_io_perm_failure)
>> >                 ixgbevf_close_suspend(adapter);
>> >
>> >         return 0;
>>
>> This fix doesn't seem right to me. It seems like you are addressing a
>> symptom instead of a cause.
>>
>> Would it make more sense to update ixgbe/ixgbevf_io_error_detected and
>> have them call ixgbe/ixgbevf_close_suspend itself before releasing the
>> RTNL mutex? Doing that would require just moving the 3 lines that
>> include the call and the trailing blank line to the spot before we
>> return on "state == pci_channel_io_perm_failure". It really seems like
>> that might be a better way to handle this since I don't see how we
>> recover from this sort of error any other way since we recommend
>> disconnecting the device based on the error result.
>>
>> Thanks.
>>
>> - Alex
>>
>
> Hi Alex,
>
> I think I got your point here, and it would apply in the scenario where
> the driver itself recommends the disconnection, I guess that is why you
> suggested to call the ixgbe/ixgbevf_close_suspend from
> ixgbe_io_error_detected before returning PCI_ERS_RESULT_DISCONNECT when
> "state == pci_channel_io_perm_failure". This is not the only case I'm
> covering here.
>
> A PCI recovery mechanism may opt, by a number of reasons, to remove a
> device even if the driver says it is possible to recovery from the
> error, usually returning PCI_ERS_RESULT_RECOVERED, which is what
> ixgbevf/ixgbe_io_error_detected does in its the success path, that is
> one example where calling ixgbe_close_suspend explicitly from that point
> wouldn't help.

Yes, but what other paths are causing the netdev to be detached? It
seems like the issue is really the fact that we are detaching the
interface in the error handler without closing it. Doing it the way I
have described would make this code path consistent with our shutdown
code path so it should be much less likely to introduce other
regressions since it essentially makes the detach request function
more like the __ixgbe_shutdown call.

> The patch as is allow us to free IRQ for both removal scenarios, i.e.
> when the driver gives up to recovery and when the PCI recovery mechanism
> opts to remove a device.
>
> Please let me know if you still have concerns or suggestions for this,
> and thank you for your review.

I still think the way I suggested is a better way to go than adding
other workarounds.

Thanks.

- Alex
