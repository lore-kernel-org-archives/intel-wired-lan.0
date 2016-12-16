From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 16 Dec 2016 19:31:39 +0100
Subject: [Intel-wired-lan] [PATCH v3 2/4] i40e: Initial support for XDP
In-Reply-To: <58542D64.2070801@gmail.com>
References: <20161213134007.14707-1-bjorn.topel@gmail.com>
 <20161213134007.14707-3-bjorn.topel@gmail.com>
 <58542D64.2070801@gmail.com>
Message-ID: <CAJ+HfNipwVAGYPs69Wa4MqhZeXfcRjp0sU84kBHQQ=rxNpHz1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

2016-12-16 19:07 GMT+01:00 John Fastabend <john.fastabend@gmail.com>:
[...]
>>
>>  /**
>> + * i40e_run_xdp - Runs an XDP program for an Rx ring
>> + * @rx_ring: Rx ring used for XDP
>> + * @rx_buffer: current Rx buffer
>> + * @rx_desc: current Rx descriptor
>> + * @size: buffer size
>> + * @xdp_prog: the XDP program to run
>> + *
>> + * Returns true if the XDP program consumed the incoming frame. False
>> + * means pass the frame to the good old stack.
>> + **/
>> +static bool i40e_run_xdp(struct i40e_ring *rx_ring,
>> +                      struct i40e_rx_buffer *rx_buffer,
>> +                      union i40e_rx_desc *rx_desc,
>> +                      unsigned int size,
>> +                      struct bpf_prog *xdp_prog)
>> +{
>> +     struct xdp_buff xdp;
>> +     u32 xdp_action;
>> +
>> +     if (unlikely(!i40e_test_staterr(rx_desc,
>> +                                     BIT(I40E_RX_DESC_STATUS_EOF_SHIFT)))) {
>> +             dev_warn_once(&rx_ring->vsi->back->pdev->dev,
>> +                           "Received unexpected RXD_EOF!\n");
>> +             goto do_drop;
>> +     }
>> +
>> +     xdp.data = page_address(rx_buffer->page) + rx_buffer->page_offset;
>> +     xdp.data_end = xdp.data + size;
>
> We need to set the xdp.data_hard_start as well here.
>
>         xdp.data_hard_start = xdp.data
>
> should be good enough for now.

OK! Thanks for pointing that out. I'll address that in v4!


Bj?rn
