From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Mon, 1 Mar 2021 13:18:32 +0100
Subject: [Intel-wired-lan] Driver i40e have XDP-redirect bug
Message-ID: <20210301131832.0d765179@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi i40e-people + XDP-feature-people, 

The driver i40e have a XDP-redirect bug, where is it partly broken. It can
transmit a redirected xdp_frame (from another driver). But broken when
redirecting a xdp_frame that is received by the driver itself.

This reminds me about lacking XDP-features, as this "state" is actually
"supported" (for Intel drivers), when running in 'legacy-rx' mode.  This can
be configured (via: 'ethtool --set-priv-flags i40e2 legacy-rx on').  When
running in 'legacy-rx' mode the headroom is zero, which means that xdp_frame
cannot be created as it is stored in this headroom, but an XDP-prog can
still run a (DDoS) filter.  (Hint grepping after xdp_redirect stats is not enough).

The BUG I experience *is* that headroom is zero, but 'legacy-rx' mode is off:

  $ ethtool --show-priv-flags i40e2 | grep legacy-rx
  legacy-rx             : off

This is clearly a driver initialization bug as the headroom should not
be zero in this configuration. Further indication that this is related
to init order: If while xdp_redirect is running, I change RX-ring size
(e.g. 'ethtool -G i40e2 rx 1024') then redirect starts working again.


I will continue to find the offending commit... (to-be-continued)
(p.s. testing on net-next on top of commit d310ec03a34e92).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

