From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 17 Nov 2021 20:49:56 -0800
Subject: [Intel-wired-lan] [PATCH net-next 5/6] devlink: Reshuffle
 resource registration logic
In-Reply-To: <6176a137a4ded48501e8a06fda0e305f9cfc787c.1637173517.git.leonro@nvidia.com>
References: <cover.1637173517.git.leonro@nvidia.com>
 <6176a137a4ded48501e8a06fda0e305f9cfc787c.1637173517.git.leonro@nvidia.com>
Message-ID: <20211117204956.6a36963b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 17 Nov 2021 20:26:21 +0200 Leon Romanovsky wrote:
> -	top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
> -
> -	mutex_lock(&devlink->lock);
> -	resource = devlink_resource_find(devlink, NULL, resource_id);
> -	if (resource) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> +	WARN_ON(devlink_resource_find(devlink, NULL, resource_id));

This is not atomic with the add now.

>  	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
>  	if (!resource) {
> @@ -9851,7 +9843,17 @@ int devlink_resource_register(struct devlink *devlink,
>  		goto out;
>  	}
>  
> -	if (top_hierarchy) {
> +	resource->name = resource_name;
> +	resource->size = resource_size;
> +	resource->size_new = resource_size;
> +	resource->id = resource_id;
> +	resource->size_valid = true;
> +	memcpy(&resource->size_params, size_params,
> +	       sizeof(resource->size_params));
> +	INIT_LIST_HEAD(&resource->resource_list);
> +
> +	mutex_lock(&devlink->lock);
