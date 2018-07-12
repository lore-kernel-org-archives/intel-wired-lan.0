From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 12 Jul 2018 09:26:39 +0300
Subject: [Intel-wired-lan] [PATCH v3 03/11] igc: Add netdev
In-Reply-To: <f64eca67-9ff5-8fd7-532c-d6f8e3dae100@oracle.com>
References: <20180624084503.10065-1-sasha.neftin@intel.com>
 <800bbf05-477f-870c-730a-bf129e1eea9a@oracle.com>
 <2d11eab6-8bd4-e444-435e-95980be23a4a@intel.com>
 <f64eca67-9ff5-8fd7-532c-d6f8e3dae100@oracle.com>
Message-ID: <4dfd9528-c1dc-2423-3c0e-e5cbbab11366@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/2/2018 19:40, Shannon Nelson wrote:
> 
> 
> On 7/2/2018 6:05 AM, Neftin, Sasha wrote:
>> On 6/27/2018 03:32, Shannon Nelson wrote:
>>> On 6/24/2018 1:45 AM, Sasha Neftin wrote:
>>>> Now that we have the ability to configure the basic settings on the 
>>>> device
> 
> [...]
> 
>>>> ? /* Board specific private data structure */
>>>> ? struct igc_adapter {
>>>> +??? struct net_device *netdev;
>>>> +
>>>> +??? unsigned long state;
>>>> +??? unsigned int flags;
>>>
>>> These state and flags fields should probably be specifically defined 
>>> as u32 or u64.
>>>
>> Let me do not agree with you here. I've a two arguments:
>> 1. general set_bit/clear_bit methods is used this type and do not 
>> allow pass another type. Actually we use set_bit/clear_bit a lot of.
>> 2. i prefer stay consistently with another driver where is used same 
>> value.
>>> Is there a reason that state is a long and flags an int?? Is there an 
>>> expectation of different sizes?
> 
> The 'state' to be used in set/clear_bit makes sense, but it might be 
> better to use DECLARE_BITMAP().
> 
> The 'flags' still might be specifically set to u32 as done in ixgbe and 
> i40e.
> 
yes, I understand. This is might be good optimization and I will 
consider do it a bit later. I would like stable my driver at first.
> [...]
> 
>>>> +
>>>> +??? strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
>>>> +
> 
> [...]
> 
>>>> +
>>>> +??? strncpy(netdev->name, "eth%d", IFNAMSIZ);
>>>
>>> You're stomping on what you just set a few lines earlier.? Of course, 
>>> some might argue that you shouldn't put anything here at all and let 
>>> the system name the device.
>>>
>> my apologies I do not understand you.
> 
> You've already set the netdev->name once, here you're setting it again 
> to something else.? In either case, the userland daemons will likely 
> change whatever you put here.
> 
> 
yes. But without using this setting of name probe method stuck with 
initialization error 22. May be wee need look a more depth into.
>>>> +??? err = register_netdev(netdev);
>>>> +??? if (err)
>>>> +??????? goto err_register;
>>>> +
>>>> +???? /* carrier off reporting is important to ethtool even BEFORE 
>>>> open */
>>>> +??? netif_carrier_off(netdev);
>>>> +
>>>> +??? dev_info(&pdev->dev, "@SUMMARY@");
>>>> +??? /* print bus type/speed/width info */
>>>> +??? dev_info(&pdev->dev, "%s: (PCIe:%s:%s) ",
>>>> +???????? netdev->name,
>>>> +???????? ((hw->bus.speed == e1000_bus_speed_2500) ? "2.5GT/s" :
>>>> +???????? (hw->bus.speed == e1000_bus_speed_5000) ? "5.0GT/s" :
>>>> +???????? "unknown"),
>>>> +???????? ((hw->bus.width == e1000_bus_width_pcie_x4) ? "Width x4" :
>>>> +???????? (hw->bus.width == e1000_bus_width_pcie_x2) ? "Width x2" :
>>>> +???????? (hw->bus.width == e1000_bus_width_pcie_x1) ? "Width x1" :
>>>> +???????? "unknown"));
>>>
>>> How about using the new pcie_print_link_status()?
>>>
>> Good idea. I will keep it in mind and replace in future. Currenly in 
>> my working kernel this method not exist yet.
> 
> Then you're using an out-of-date kernel and you should update to what is 
> currently upstream.
> 
Good. I've liked this API and upgraded kernel to 4.18+. fix will be 
applied in v4.
> sln
