From: David Sterba <dsterba@suse.cz>
Date: Tue, 14 Apr 2020 14:48:54 +0200
Subject: [Intel-wired-lan] [PATCH 1/2] mm,
 treewide: Rename kzfree() to kfree_sensitive()
In-Reply-To: <20200413211550.8307-2-longman@redhat.com>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413211550.8307-2-longman@redhat.com>
Message-ID: <20200414124854.GQ5920@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Apr 13, 2020 at 05:15:49PM -0400, Waiman Long wrote:
>  fs/btrfs/ioctl.c                              |  2 +-


> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 40b729dce91c..eab3f8510426 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2691,7 +2691,7 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
>  	btrfs_put_root(root);
>  out_free:
>  	btrfs_free_path(path);
> -	kzfree(subvol_info);
> +	kfree_sensitive(subvol_info);

This is not in a sensitive context so please switch it to plain kfree.
With that you have my acked-by. Thanks.
