From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 11 Oct 2021 15:29:13 -0700
Subject: [Intel-wired-lan] Potential bio_vec networking/igb size
 dependency?
In-Reply-To: <2757afa0-1b27-8480-0830-9638b2495a85@kernel.dk>
References: <2757afa0-1b27-8480-0830-9638b2495a85@kernel.dk>
Message-ID: <20211011152913.07ec6087@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 11 Oct 2021 16:09:55 -0600 Jens Axboe wrote:
> Hi,
> 
> Been working on a change today that changes struct bio_vec, and it works
> fine on the storage side. But when I boot the box with the change, I
> can't ssh in. If I attempt to use networking on the box (eg to update
> packages), it looks like the data is corrupt. Basic things work - I can
> dhcp and get an IP and so on, but ssh in yields:
> 
> ssh -v box
> [...]
> debug1: Local version string SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.3
> debug1: Remote protocol version 2.0, remote software version OpenSSH_8.2p1 Ubuntu-4ubuntu0.3
> debug1: match: OpenSSH_8.2p1 Ubuntu-4ubuntu0.3 pat OpenSSH* compat 0x04000000
> debug1: Authenticating to box as 'axboe'
> debug1: SSH2_MSG_KEXINIT sent
> debug1: SSH2_MSG_KEXINIT received
> debug1: kex: algorithm: curve25519-sha256
> debug1: kex: host key algorithm: ecdsa-sha2-nistp256
> debug1: kex: server->client cipher: chacha20-poly1305 at openssh.com MAC: <implicit> compression: none
> debug1: kex: client->server cipher: chacha20-poly1305 at openssh.com MAC: <implicit> compression: none
> debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
> Connection closed by 207.135.234.126 port 22
> 
> I've got a vm image that I boot on my laptop, and that seems to
> work fine. Hence I'm thinking maybe it's an igb issue? But for the
> life of me, I cannot figure out wtf it is. I've looked at the skb_frag_t
> uses and nothing pops out at me.
> 
> Trivial to reproduce, just add the below patch.
> 
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index 0e9bdd42dafb..e61967fb4643 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -33,6 +33,7 @@ struct bio_vec {
>  	struct page	*bv_page;
>  	unsigned int	bv_len;
>  	unsigned int	bv_offset;
> +	unsigned long	foo;
>  };
>  
>  struct bvec_iter {

Yeah, changing the size of bvec now that skb uses it may be lots of
pain. Are you trying to grow it?

We place skb_shared_info (which holds frags) after packet data in 
a packet buffer, so changing skb_shared_info may trip expectations 
that a lot of drivers have about layout of the buffers.

Let's see what igb does wrong...
