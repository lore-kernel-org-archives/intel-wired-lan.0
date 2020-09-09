From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Wed, 9 Sep 2020 17:37:14 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] xsk: exit NAPI loop when
 AF_XDP Rx ring is full
In-Reply-To: <11f663ec-5ea7-926c-370d-0b67d3052583@nvidia.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
 <0257f769-0f43-a5b7-176d-7c5ff8eaac3a@intel.com>
 <11f663ec-5ea7-926c-370d-0b67d3052583@nvidia.com>
Message-ID: <20200909173714.25a3ce43@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 8 Sep 2020 13:32:01 +0300
Maxim Mikityanskiy <maximmi@nvidia.com> wrote:

>  From the driver API perspective, I would prefer to see a simpler API if 
> possible. The current API exposes things that the driver shouldn't know 
> (BPF map type), and requires XSK-specific handling. It would be better 
> if some specific error code returned from xdp_do_redirect was reserved 
> to mean "exit NAPI early if you support it". This way we wouldn't need 
> two new helpers, two xdp_do_redirect functions, and this approach would 
> be extensible to other non-XSK use cases without further changes in the 
> driver, and also the logic to opt-in the feature could be put inside the 
> kernel.

I agree.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

